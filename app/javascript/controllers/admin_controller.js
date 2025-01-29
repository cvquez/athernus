import {Controller} from "@hotwired/stimulus"
import feather from "feather-icons";

// Connects to data-controller="admin"
export default class extends Controller {
    connect() {
        this.onSubmit = this.onSubmit.bind(this);
        this.onPageLengthChange = this.onPageLengthChange.bind(this);
        $(document).on("click", "a[href=\\#submit]", this.onSubmit);
        $(document).on("change", '.page-length', this.onPageLengthChange);
        // $('[data-uploaded-file]').each(function () {
        //     if ($(this).closest('.drag_and_drop').hasClass('form-group-invalid'))
        //         $(this).remove();
        // });
        $("[data-bs-toggle=popover]").each(function () {
            new bootstrap.Popover(this, {});
        });
        try {
            feather.replace();
        } catch (e) {
            console.log(e)
        }
    }

    onPageLengthChange(evt) {
        $(evt.currentTarget).closest("form").submit();
    }

    onSubmit(evt) {
        evt.preventDefault();
        evt.stopPropagation();
        let $form = $("form.simple_form");
        if ($form.length) $form[0].requestSubmit();
    }

    disconnect() {
        $(document).off("click", "a[href=\\#submit]", this.onSubmit);
        $(document).off("change", '.page-length', this.onPageLengthChange);
    }
}
