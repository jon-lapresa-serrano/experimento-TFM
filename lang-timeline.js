function new_timeline() {
  /* defining test timeline*/
  var lang = {
    timeline: [{
      type: 'survey-html-form',
      preamble: '<p> Por favor indique qué otros idiomas habla y su nivel de competencia. </p>',
      html: '<p> <input name="L2" type="text" /> <select name="ProficiencyL2">' + L_box + '<p> <input name="L3" type="text" /> <select name="ProficiencyL3">' + L_box + '<p> <input name="L4" type="text" /> <select name="ProficiencyL4">' + L_box + '<p> <input name="L5" type="text" /> <select name="ProficiencyL5">' + L_box + '<p> <input name="L6" type="text" /> <select name="ProficiencyL6">' + L_box + '<p> <input name="L7" type="text" /> <select name="ProficiencyL7">' + L_box + '<p> <input name="L8" type="text" /> <select name="ProficiencyL8">' + L_box + '<p> <input name="L9" type="text" /> <select name="ProficiencyL9">' + L_box + '<p> <input name="L10" type="text" /> <select name="ProficiencyL10">' + L_box + '<p> <input name="L11" type="text" /> <select name="ProficiencyL11">' + L_box
    }],
  };
  return [lang];
}
