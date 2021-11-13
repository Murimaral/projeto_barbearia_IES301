import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'materialize-css/dist/js/materialize'

import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';
import listPlugin from '@fullcalendar/list';
import interactorPlugin from '@fullcalendar/interaction';

require('jquery')
global.moment = require('moment')
global.Calendar = Calendar
global.dayGridPlugin = dayGridPlugin
global.timeGridPlugin = timeGridPlugin
global.listPlugin = listPlugin
global.interactorPlugin = interactorPlugin

Rails.start()
ActiveStorage.start()
window.onload = () => {
  M.AutoInit()
}


