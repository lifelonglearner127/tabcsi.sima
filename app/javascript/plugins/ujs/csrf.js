export const csrfParam = () => {
  const meta = document.querySelector('meta[name=csrf-param]')

  return meta && meta.content
}

export const csrfToken = () => {
  const meta = document.querySelector('meta[name=csrf-token]')

  return meta && meta.content
}
