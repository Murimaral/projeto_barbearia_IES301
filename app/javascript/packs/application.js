import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'materialize-css/dist/js/materialize'
require('jquery')

Rails.start()
ActiveStorage.start()
window.onload = () => {
  M.AutoInit()
}