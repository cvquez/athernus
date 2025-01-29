import {Controller} from "@hotwired/stimulus"
import Sortable from "sortablejs";

// Connects to data-controller="sortable"
export default class extends Controller {
    static values = {
        settings: Object
    }

    connect() {
        this.sortable = new Sortable(this.element, this.settings);
    }

    onSort(e) {
        if (this.settingsValue['url'] && this.settingsValue['url'].trim().length > 0) {
            let self = this;
            $.ajax({
                url: this.settingsValue['url'],
                type: "PATCH",
                data: {position: self.sortable.toArray()},
                success: function (data) {
                },
                error: function (data) {
                },
            });
        }
    }

    get settings() {
        return {
            animation: this.settingsValue['animation'] || 150,
            onSort: this.onSort.bind(this),
            handle: this.settingsValue['handle'] || ''
        };
    }


    disconnect() {
        this.sortable.destroy();
    }
}
