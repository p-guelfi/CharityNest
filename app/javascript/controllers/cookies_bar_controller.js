import { Controller } from "@hotwired/stimulus"
import Cookies from "js-cookie"

export default class extends Controller {
  connect() {
    if (this.areCookiesAllowed()) {
      this.appendGACode();
    }
  }

  areCookiesAllowed() {
    return Cookies.get("allow_cookies") === "yes";
  }

  allowCookies() {
    Cookies.set('allow_cookies', 'yes', {
      expires: 365
    });

    this.appendGACode();
    this.hideBar();
  }

  rejectCookies() {
    Cookies.set('allow_cookies', 'no', {
      expires: 365
    });

    this.hideBar();
  }

  hideBar() {
    this.element.classList.add('hidden');
  }

  appendGACode() {
    const tagManagerScriptTag = document.createElement("script");
    const eventsScriptTag = document.createElement("script");

    tagManagerScriptTag.src = "https://www.googletagmanager.com/gtag/js?id=G-DNJN1PF3CS";
    tagManagerScriptTag.async = true;

    eventsScriptTag.textContent = 'window.dataLayer = window.dataLayer || [];\
      function gtag(){dataLayer.push(arguments);}\
      gtag("js", new Date());\
      gtag("config", "G-XXXXXXX");';

    document.getElementsByTagName('head')[0].appendChild(tagManagerScriptTag);
    document.getElementsByTagName('head')[0].appendChild(eventsScriptTag);
  }
}
