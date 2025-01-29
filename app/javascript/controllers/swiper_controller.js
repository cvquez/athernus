import {Controller} from "@hotwired/stimulus";
// import Swiper from "swiper";

// Connects to data-controller="swiper"
export default class extends Controller {
    static targets = ["swiper", "pagination", "next", "prev"];
    static values = {
        options: Object,
    };

    connect() {
        this.dataset = this.element.dataset;
        let el = this.hasSwiperTarget ? this.swiperTarget : this.element;
        this.swiper = new Swiper(el, this.mergedOptions);
    }

    disconnect() {
        this.swiper.destroy();
        this.swiper = undefined;
    }

    get mergedOptions() {
        let options = {
            ...this.defaultOptions,
            ...this.optionsValue,
        };
        if (options["autoplayDelay"]) {
            options["autoplay"]["delay"] = options["autoplayDelay"];
        }
        return options;
    }

    get defaultOptions() {
        let defaults = {
            slidesPerView: 1,
            autoplay: {delay: 5000, disableOnInteraction: false, pauseOnMouseEnter: true}
        };
        if (this.hasPaginationTarget) defaults.pagination = {el: this.paginationTarget, clickable: true};
        if (this.hasNextTarget || this.hasPrevTarget) {
            defaults.navigation = {};
            if (this.hasNextTarget) defaults.navigation.nextEl = this.nextTarget;
            if (this.hasPrevTarget) defaults.navigation.prevEl = this.prevTarget;
        }
        if(this.dataset.prevBtn || this.dataset.nextBtn){
            defaults.navigation = {};
            if (this.dataset.prevBtn) defaults.navigation.prevEl = this.dataset.prevBtn;
            if (this.dataset.nextBtn) defaults.navigation.nextEl = this.dataset.nextBtn;
        }
        return defaults;
    }
}
