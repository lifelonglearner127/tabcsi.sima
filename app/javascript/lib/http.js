import assign from 'lodash/assign'
import axios from 'axios'
import { csrfToken } from '~/plugins/ujs/csrf'
import forEach from 'lodash/forEach'
import FormDataBuilder from './form-data-builder'
import GetParamsBuilder from './get-params-builder'
import isString from 'lodash/isString'

class HttpError extends Error {
  constructor (options) {
    super('HTTP Error')

    this._requestError = Boolean(options.requestError)
    this._responseError = Boolean(options.responseError)
    this._errors = options.errors

    Object.defineProperty(this, 'requestError', {
      get () {
        return this._requestError
      }
    })

    Object.defineProperty(this, 'responseError', {
      get () {
        return this._responseError
      }
    })

    Object.defineProperty(this, 'errors', {
      get () {
        return this._errors
      }
    })
  }
}

const ACCEPT_HEADERS = {
  '*': '*/*',
  text: 'text/plain',
  html: 'text/html',
  xml: 'application/xml, text/xml',
  json: 'application/json, text/javascript',
  script: 'text/javascript, application/javascript, application/ecmascript, application/x-ecmascript'
}

class Http {
  constructor () {
    this.client = axios.create({
      headers: { 'Access-Control-Allow-Origin': '*' },
      responseType: 'json',
      timeout: 0,
      xsrfHeaderName: 'X-CSRF-Token'
    })

    this.client.interceptors.request.use(
      (req) => {
        req.headers.Accept = this.constructor.acceptHeader(req)

        // Set Content-Type only when sending a string. Sending FormData will
        // automatically set Content-Type to multipart/form-data.
        if (isString(req.data)) {
          req.headers['Content-Type'] = 'application/x-www-form-urlencoded; charset=UTF-8'
        }

        req.headers['X-CSRF-Token'] = csrfToken()

        return req
      },
      (err) => {
        err.requestError = true

        return Promise.reject(err)
      }
    )

    this.client.interceptors.response.use(
      undefined,
      (err) => {
        err.responseError = true

        return Promise.reject(err)
      }
    )

    this.createMethods()
  }

  static acceptHeader (req) {
    let value

    if (ACCEPT_HEADERS[req.responseType] == null) {
      // use "*" as default responseType
      req.responseType = '*'
    }

    value = ACCEPT_HEADERS[req.responseType]
    if (req.responseType !== '*') {
      value += ', */*; q=0.01'
    }

    return value
  }

  createMethods () {
    forEach(['delete', 'get', 'head', 'options'], (method) => {
      this[method] = (url, params, config) => this.request(
        method, url, assign({}, config, { params: GetParamsBuilder.build(params) })
      )
    })

    forEach(['post', 'put', 'patch'], (method) => {
      this[method] = (url, data, config) => this.request(
        method, url, FormDataBuilder.build(data), config
      )
    })
  }

  request (method, ...args) {
    return this.client[method](...args)
      .catch((err) => {
        const errors = err.response.data.error
        const curatedErrors = []

        forEach(errors, (error) => {
          let message

          const { detail, title } = error

          if (title === detail) {
            message = title
          } else {
            message = `${title}: ${detail}`
          }

          console.error('HTTP Error:', message) // eslint-disable-line no-console

          curatedErrors.push({
            ...error,
            message
          })
        })

        return Promise.reject(new HttpError({
          requestError: err.requestError,
          responseError: err.responseError,
          errors: curatedErrors
        }))
      })
  }
}

export default new Http()
