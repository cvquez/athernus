import {Controller} from "@hotwired/stimulus";
import SimpleBar from "simplebar";

export default class extends Controller {
    connect() {
        this.recalculateSimplebar = this.recalculateSimplebar.bind(this);
        this.toggleSidebar = this.toggleSidebar.bind(this);
        this.$element = $(this.element);
        this.$simplebar = this.$element.find(".js-simplebar");
        this.simplebarInstance = new SimpleBar(this.$simplebar[0]);
        this.$element.find("[data-bs-parent]").on("shown.bs.collapse hidden.bs.collapse", this.recalculateSimplebar);
        $(document).on("click", ".js-sidebar-toggle", this.toggleSidebar);
    }

    disconnect() {
        this.$element.find("[data-bs-parent]").off("shown.bs.collapse hidden.bs.collapse", this.recalculateSimplebar);
        $(document).off("click", ".js-sidebar-toggle", this.toggleSidebar);
    }

    recalculateSimplebar() {
        this.simplebarInstance && this.simplebarInstance.recalculate();
    }

    toggleSidebar(event) {
        const $sidebarElement = this.$element;
        $sidebarElement.toggleClass("collapsed");
        $sidebarElement.on("transitionend", this.handleResize);
    }

    handleResize() {
        $(window).trigger("resize");
    }
}
