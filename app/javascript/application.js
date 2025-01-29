import "@hotwired/turbo-rails"
import "./controllers"

import jquery from 'jquery';
import "./modules/admin-utils"
import 'bootstrap';
import Swiper from 'swiper/bundle';
import "@fortawesome/fontawesome-free/js/all";
import Swal from "sweetalert2";

window.jQuery = jquery;
window.$ = jquery;

window.Swiper = Swiper;
window.swal = Swal

// window.typeahead = typeahead;
window.Swiper = Swiper;
// window.Navigation = Navigation;
// window.Pagination = Pagination;

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
