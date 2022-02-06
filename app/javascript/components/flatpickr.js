import flatpickr from "flatpickr";

const initFlatpickr = () => {
  flatpickr(".datepicker", { disableMobile: "true"});
}

export { initFlatpickr };
