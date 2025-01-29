import "@hotwired/turbo-rails"
import "./controllers"

import "./modules/jquery.all"
import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import ActiveStorageDragAndDrop from 'active_storage_drag_and_drop'
import HLJS from 'highlight.js/lib/core';
import json from 'highlight.js/lib/languages/json';
import "@fortawesome/fontawesome-free/js/all";
import Swal from "sweetalert2";
import "chartkick/chart.js";


HLJS.registerLanguage('json', json);
Rails.start()
//Turbolinks.start()
ActiveStorage.start()
ActiveStorageDragAndDrop.start();

require("trix")
require("@rails/actiontext")
require("@nathanvda/cocoon")
require('@selectize/selectize');

window.swal = Swal
window.HLJS = HLJS
window.Rails = Rails
window.Toast = Swal.mixin({
    toast: true,
    position: 'bottom-end',
    showConfirmButton: false,
    timer: 5000,
    timerProgressBar: true,
    didOpen: (toast) => {
        toast.addEventListener('mouseenter', Swal.stopTimer)
        toast.addEventListener('mouseleave', Swal.resumeTimer)
    }
});
function confirmAction(message, element) {
    Swal.fire({
        // title: message || '¿Estas seguro?',
        text: message || '¿Estas seguro?',
        icon: 'question',
        showCancelButton: true,
        confirmButtonText: 'Aceptar',
        cancelButtonText: 'Cancelar',
    }).then((result) => {
        if (result.isConfirmed) {
            element.removeAttribute('data-confirm');
            element.click();
        }
    });
}
Rails.confirm = function (message, element) {
    confirmAction(message, element);
    return false;
};
