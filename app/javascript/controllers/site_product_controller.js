import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="site-product"
export default class extends Controller {
    connect() {
        this.$modal = $("#coverage-modal");
        $(document).on('click', '.backdrop-icon', this.showModal.bind(this));
    }

    showModal(e) {
        e.preventDefault();
        let $target = e.currentTarget;
        this.$modal.find('.coverage-name').text($target.dataset.name);
        this.$modal.find('.coverage-description').html($target.dataset.description);
        $("#coverage-modal").modal("show");
    }

    disconnect() {
        $(document).off('click', '.backdrop-icon');
    }
}
