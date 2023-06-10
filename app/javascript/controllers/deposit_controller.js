import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="deposit"
export default class extends Controller {
  static targets = [
    "cpfField",
    "classroomField",
    "amountField",
    "submitButton",
  ];

  cpfValueChanged() {
    const cpfValue = this.cpfFieldTarget.value;
    this.classroomFieldTarget.disabled = cpfValue !== "";
  }

  classroomValueChanged() {
    const classroomValue = this.classroomFieldTarget.value;
    this.cpfFieldTarget.disabled = classroomValue !== "";
  }

  amountValueChanged() {
    const amountValue = this.amountFieldTarget.value;
    this.submitButtonTarget.disabled = amountValue === "";
  }

  connect() {
    this.submitButtonTarget.disabled = true;
  }
}
