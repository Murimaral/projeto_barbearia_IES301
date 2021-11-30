import Rails from "@rails/ujs";
import * as ActiveStorage from "@rails/activestorage";
import "channels";
import "materialize-css/dist/js/materialize";

import { Calendar } from "@fullcalendar/core";
import brLocale from "@fullcalendar/core/locales/pt-br";
import dayGridPlugin from "@fullcalendar/daygrid";
import timeGridPlugin from "@fullcalendar/timegrid";
import listPlugin from "@fullcalendar/list";
import interactorPlugin from "@fullcalendar/interaction";

require("jquery");
global.moment = require("moment");
global.Calendar = Calendar;
global.dayGridPlugin = dayGridPlugin;
global.timeGridPlugin = timeGridPlugin;
global.listPlugin = listPlugin;
global.interactorPlugin = interactorPlugin;
global.brLocale = brLocale;

Rails.start();
ActiveStorage.start();

$(document).ready(function() {
  M.AutoInit();

  $(".datepicker").datepicker({
    i18n: {
      months: [
        "Janeiro",
        "Fevereiro",
        "Março",
        "Abril",
        "Maio",
        "Junho",
        "Julho",
        "Agosto",
        "Setembro",
        "Outubro",
        "Novembro",
        "Dezembro"
      ],
      monthsShort: [
        "Jan",
        "Fev",
        "Mar",
        "Abr",
        "Mai",
        "Jun",
        "Jul",
        "Ago",
        "Set",
        "Out",
        "Nov",
        "Dez"
      ],
      weekdays: [
        "Domingo",
        "Segunda",
        "Terça",
        "Quarta",
        "Quinta",
        "Sexta",
        "Sabádo"
      ],
      weekdaysShort: ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sab"],
      weekdaysAbbrev: ["D", "S", "T", "Q", "Q", "S", "S"],
      today: "Hoje",
      clear: "Limpar",
      cancel: "Sair",
      done: "Confirmar",
      labelMonthNext: "Próximo mês",
      labelMonthPrev: "Mês anterior",
      labelMonthSelect: "Selecione um mês",
      labelYearSelect: "Selecione um ano",
      selectMonths: true,
      selectYears: 15
    },
    format: "dd/mm/yyyy",
    container: "body",
    minDate: new Date()
  });

  $(".timepicker").timepicker({ twelveHour: false });
});
