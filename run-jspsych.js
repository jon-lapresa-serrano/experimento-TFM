function run_jspsych() {
  jsPsych.init({
    timeline: new_timeline(),
    display_element: 'js_psych',
    on_finish: function() {
      var json_data = jsPsych.data.get().json();
      Shiny.onInputChange("jspsych_results", json_data);
      next_page();
    }
  });
}
run_jspsych();
