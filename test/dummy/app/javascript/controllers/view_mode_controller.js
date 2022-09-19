import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  connect () {
    this.save(this.mode || this.defaultMode)
  }

  toggle () {
    if (this.mode === 'dark') return this.save('light')
    this.save('dark')
  }

  save (value) {
    document.documentElement.classList.remove('light', 'dark')
    document.documentElement.classList.add(value)
    return localStorage.setItem('view-mode', value)
  }

  get mode () {
    return localStorage.getItem('view-mode')
  }

  get defaultMode () {
    let mode = 'light'
    if (window.matchMedia('(prefers-color-scheme: dark)').matches) mode = 'dark'
    return mode
  }
}
