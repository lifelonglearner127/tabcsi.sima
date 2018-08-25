export const isCrossDomain = (url) => {
  const originAnchor = document.createElement('a')
  const urlAnchor = document.createElement('a')

  originAnchor.href = location.href

  try {
    urlAnchor.href = url

    return ((urlAnchor.protocol && urlAnchor.protocol !== ':') || urlAnchor.host) &&
      `${originAnchor.protocol}//${originAnchor.host}` !== `${urlAnchor.protocol}//${urlAnchor.host}`
  } catch (error) {
    // If there is an error parsing the URL, assume it is crossDomain.
    return true
  }
}
