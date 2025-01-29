import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="user-policies"
export default class extends Controller {
    connect() {
        this.toggleTabs = this.toggleTabs.bind(this);
        $(document).on('click', '.policy-tab-link', this.toggleTabs)
    }

    toggleTabs(e) {
        e.preventDefault();
        const policy = $(e.currentTarget).data('slug');
        $(".policy-tab").addClass("inactive").removeClass('active');
        $(`.policy-tab#${policy}`).addClass("active").removeClass('inactive');
        $(".policy-tab.inactive").hide();
        $(".policy-tab.active").show();
        $(".policy-tab-link.active").removeClass('active');
        $(e.currentTarget).addClass('active');
    }

    disconnect() {
        $(document).off('click', '.policy-tab-link', this.toggleTabs);
    }
}
