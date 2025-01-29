import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="recaptcha"
// Needs to be inside the <form>
export default class extends Controller {
    connect() {
        this.$form = $(this.element).closest("form");
        this.$submit = this.$form.find("input[type=submit]");
        // this.optWidgetId = 0; For future use

        this.onSubmit = this.onSubmit.bind(this);
        this.render = this.render.bind(this);
        this.submitForm = this.submitForm.bind(this);
        this.onError = this.onError.bind(this);

        this.$form.on("submit", this.onSubmit);
        AdminUtils.waitForVariable('grecaptcha', 5, this.render);
    }

    onSubmit(evt) {
        if (window["grecaptcha"].getResponse() === "") {
            evt.preventDefault();
            evt.stopPropagation();
            window["grecaptcha"].execute();
        }
    }

    submitForm() {
        if (this.$form[0]) this.$form[0].requestSubmit();
    }

    onError() {
        console.log("Error")
    }

    render() {
        AdminUtils.waitForVariable('render', 5, () => {
            window["grecaptcha"].render("recaptchaV2", {
                'sitekey': this.element.dataset.siteKey,
                'size': 'invisible',
                'callback': this.submitForm,
                'error-callback': this.onError
            });
        }, window["grecaptcha"]);
    }

    disconnect() {
        this.$form.off("submit", this.onSubmit);
        this.$form.find("#recaptchaV2").html("");
    }
}
