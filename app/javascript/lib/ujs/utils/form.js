import './dom'
import filter from 'lodash/filter'
import forEach from 'lodash/forEach'
import includes from 'lodash/includes'
import map from 'lodash/map'
import Rails from '../rails'
import toArray from 'lodash/toArray'

const { matches } = Rails

Rails.serializeElement = (element, additionalParam) => {
  let inputs

  const params = []

  inputs = [element]
  if (matches(element, 'form')) {
    inputs = toArray(element.elements)
  }

  forEach(inputs, (input) => {
    if (!input.name || input.disabled) {
      return
    }

    if (matches(input, 'select')) {
      params.push(
        ...map(
          filter(toArray(input.options), 'selected'),
          (option) => ({
            name: input.name,
            value: option.value
          })
        )
      )
    } else if (input.checked || !includes(['radio', 'checkbox', 'submit'], input.type)) {
      params.push({
        name: input.name,
        value: input.value
      })
    }
  })

  if (additionalParam) {
    params.push(additionalParam)
  }

  return map(params, (param) => {
    if (param.name == null) {
      return param
    }

    return `${encodeURIComponent(param.name)}=${encodeURIComponent(param.value)}`
  }).join('&')
}

// Helper function that returns form elements that match the specified CSS selector. If form is actually a "form"
// element this will return associated elements outside the form that have the html `form` attribute set.
Rails.formElements = (form, selector) => {
  if (matches(form, 'form')) {
    return filter(toArray(form.elements), (el) => matches(el, selector))
  }

  return toArray(form.querySelectorAll(selector))
}
