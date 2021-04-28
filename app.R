# Sys.setlocale("LC_ALL","es_ES")

# # ####################################################
# # # This script makes a psychTestR implementation of
# # # Gender Stroop Task
# # # Date:2021
# # # Author: Jon Lapresa-Serrano
# # # Project group: X
# # ###################################################


library(htmltools)
library(psychTestR)
library(tibble)
library(shiny)
library(jspsychr)
library(dplyr)

base_dir <- "/srv/shiny-server/experimento-TFM"
jspsych_dir <- file.path(base_dir, "jspsych-6-2")

write_to_file <- function(json_object,file_name,var_name=NULL){
  OS_type = .Platform
  if(is.null(var_name)){
    # if(OS_type$OS.type == "windows"){
    #   fileConn<-file(file_name)
    #   writeLines(json_object, fileConn, useBytes=TRUE)
    #   close(fileConn)
    # }else{
      write(json_object, file=file_name)
    # }
  }else{
    # if(OS_type$OS.type == "windows"){
    #   fileConn<-file(file_name)
    #   writeLines(paste("var ",var_name,"= ", json_object), fileConn, useBytes=TRUE)
    #   close(fileConn)
    # }else{
      write(paste("var ",var_name,"= ", json_object), file=file_name)
    # }
  }
}

# create dataframe to define stimuli
# setting up a list of the possible response key configurations
resps = list(c("leftarrow","uparrow","rightarrow"),
             c("leftarrow","rightarrow","uparrow"),
             c("uparrow","leftarrow","rightarrow"),
             c("rightarrow","leftarrow","uparrow"),
             c("uparrow","rightarrow","leftarrow"),
             c("rightarrow","uparrow","leftarrow"))
# randomizing the selection of response key configuration
rand_resp = sample(1:length(resps))
response_config = resps[[rand_resp[1]]]

# stim = c("los alumnos", "los estudiantes", "los vecinos", "los diputados", "los clientes", "los profesores", "los abogados", "los ministros", "los empresarios", "les alumnes","les estudiantes", "les vecines", "les diputades", "les clientes", "les profesores", "les abogades", "les ministres", "les empresaries", "el alumnado","el estudiantado", "el vecindario", "la diputaci?n", "la clientela", "el profesorado", "la abogac?a", "el ministerio", "el empresariado", "los mosquitos", "los vasos", "los lobos", "los perros", "los dientes", "los pinos", "las islas", "las pastillas", "los p?jaros", "los mosquitones", "los vasones", "los lobillos", "los perrones", "los dientillos", "los pinillos", "las islonas", "las pastillonas", "los pajarrones", "la mosquitera", "la vasija", "el lobezno", "la perrada", "la dentadura", "el pinar", "el islote", "el pastillero", "la pajarita")
stim1 = c("los alumnos", "los estudiantes", "los vecinos", "los diputados", "los clientes", "los profesores")
stim2 = c("los abogados", "los ministros", "los empresarios", "les alumnes","les estudiantes", "les vecines")
stim3 = c("les diputades", "les clientes", "les profesores", "les abogades", "les ministres", "les empresaries")
stim4 = c("el alumnado","el estudiantado", "el vecindario", "la diputación", "la clientela", "el profesorado")
stim5 = c("la abogacía", "el ministerio", "el empresariado", "los mosquitos", "los vasos", "los lobos")
stim6 = c("los perros", "los dientes", "los pinos", "las islas", "las pastillas", "los pájaros", "los mosquitones")
stim7 = c("los vasones", "los lobillos", "los perrones", "los dientillos", "los pinillos", "las islonas")
stim8 = c("las pastillonas", "los pajarrones", "la mosquitera", "la vasija", "el lobezno", "la perrada")
stim9 = c("la dentadura", "el pinar", "el islote", "el pastillero", "la pajarita")

stim = c(stim1, stim2, stim3, stim4, stim5, stim6, stim7, stim8, stim9)

stroop_stim <- data.frame( stimulus = length(54*3),
                           word = rep(stim, each=3),
                           color = rep(c("red","green","blue"), 54),
                           response = rep(response_config, 54),
                           resp_config = rep(rand_resp[[1]], 54*3),
                           stim_type = rep(c("1", "2", "3", "4", "5", "6"), each=9*3), 
                           id = "stroop_stim",
                           fontsize = "60pt",
                           lineheight = "normal") %>%
  mutate(stim_type = recode(stim_type, '1' = "gender_masc", '2' = "gender_neut", '3' = "gender_coll", '4' = "control_masc", '5' = "control_neut", '6' = "control_coll"))

stroop_prac_stim <- data.frame( stimulus = length(3*5),
                                word = rep(c("EJEMPLO", "EL EJEMPLO", "LOS EJEMPLOS"), each=5),
                                color = rep(c("red","green","blue"), 5),
                                response = rep(response_config, 5),
                                resp_config = rep(rand_resp[[1]], 5),
                                id = "stroop_pract_stim",
                                fontsize = "60pt",
                                lineheight = "normal")

# line to make it a test:
# stroop_stim = stroop_stim[-c(21:(54*3)), ]

# write html definitions to the stimulus column
# note this could be added as a pipe to the above, setting df=.
stroop_stim$stimulus <- html_stimulus(df = stroop_stim, 
                                      html_content = "word",
                                      html_element = "p",
                                      column_names = c("color","fontsize","lineheight"),
                                      css = c("color", "font-size", "line-height"),
                                      id = "id")

stroop_prac_stim$stimulus <- html_stimulus(df = stroop_prac_stim,
                                           html_content = "word",
                                           html_element = "p",
                                           column_names = c("color","fontsize","lineheight"),
                                           css = c("color", "font-size", "line-height"),
                                           id = "id")

# create json object from dataframe
stimulus_json <- stimulus_df_to_json(df = stroop_stim,
                                     stimulus = "stimulus",
                                     data = c("word","color","response","stim_type"))

stimulus_prac_json <- stimulus_df_to_json(df = stroop_prac_stim,
                                          stimulus = "stimulus",
                                          data = c("word","color","response"))

# write json object to script
# write_to_script(stimulus_json,"test_stimuli")
# write_to_script(stimulus_prac_json,"prac_stimuli")
write_to_file(stimulus_json, paste0(base_dir, "/test_stimuli.js"), "test_stimuli")
write_to_file(stimulus_prac_json, paste0(base_dir, "/prac_stimuli.js"), "prac_stimuli")


names_arrow <- setNames(c('&#x2190', '&#x2191', '&#x2192'), c('leftarrow', 'uparrow', 'rightarrow'))
red_style=paste0("<span style='color:red;font-size:24pt;line-height:normal'>", names_arrow[response_config[1]], " (rojo)</span>")
green_style=paste0("<span style='color:green;font-size:24pt;line-height:normal'>", names_arrow[response_config[2]], " (verde)</span>")
blue_style=paste0("<span style='color:blue;font-size:24pt;line-height:normal'>", names_arrow[response_config[3]], " (azul)</span>")

resp_arrows = c(paste(red_style, "&emsp;&emsp;", green_style, "&emsp;&emsp;", blue_style),
                paste(red_style, "&emsp;&emsp;", blue_style, "&emsp;&emsp;", green_style),
                paste(green_style, "&emsp;&emsp;", red_style, "&emsp;&emsp;", blue_style),
                paste(green_style, "&emsp;&emsp;", blue_style, "&emsp;&emsp;", red_style),
                paste(blue_style, "&emsp;&emsp;", red_style, "&emsp;&emsp;", green_style),
                paste(blue_style, "&emsp;&emsp;", green_style, "&emsp;&emsp;", red_style))


instr1_stim = paste("<p>Muchas gracias por completar la encuesta previa.</p>",
                  "<p>En este experimento verá una palabra de un color (azul, rojo o verde) como la siguiente:</p>",
                  "<p style='color:red;font-size:60pt;line-height:normal'>EJEMPLO</p>",
                  "<p>Tras ver la palabra usted tendrá que pulsar las siguientes teclas de dirección de su teclado:</p>",
                  resp_arrows[rand_resp[[1]]],
                  "<p>Pulse tan rápido como pueda para identificar el color de las palabras que vea.</p>",
                  "<p>Intente memorizar ahora qué tecla de dirección está relacionada con cada color.</p>",
                  "<p>Pulse 'Continuar' para realizar una pequeña práctica antes del experimento. Recuerde memorizar antes las teclas.</p>")

instr2_stim = paste("<p>Muchas gracias por completar la práctica del experimento. </p>",
                   "<p>Ahora dará comienzo la versión completa del experimento, que funcionará de la misma manera que la práctica.</p>", 
                   "<p>Recuerde pulsar la tecla de dirección correspondiente tan rápido como pueda:</p>",
                   resp_arrows[rand_resp[[1]]],
                   "<p>Esta versión completa del experimento durará aproximadamente seis minutos.</p>",
                   "<p>Pulse 'Continuar' para comenzar el experimento.</p>")

instr1_stim_df = data.frame(stimulus = instr1_stim)
instr2_stim_df = data.frame(stimulus = instr2_stim)

# create json object from dataframe
instr1_json <- stimulus_df_to_json(df = instr1_stim_df,
                                     stimulus = "stimulus")
instr2_json <- stimulus_df_to_json(df = instr2_stim_df,
                                      stimulus = "stimulus")
# write json object to script
write_to_file(instr1_json, paste0(base_dir, "/instr1_text.js"), "instr_text")
write_to_file(instr2_json, paste0(base_dir, "/instr2_text.js"), "instr_text")

###############################
##### jsPsych starts here #####
###############################

# # For jsPsych
# library_dir <- "jspsych/jspsych-6.1.0"
# custom_dir <- "jspsych/js"

head <- tags$head(
  # jsPsych files
  
  
  # If you want to use original jspsych.js, use this:
  includeScript(file.path(jspsych_dir, "jspsych.js")),
  
  # If you want to display text while preloading files (to save time), specify your intro_text
  # in jsPsych.init (in run-jspsych.js) and call jspsych_preloadprogressbar.js here:
  # includeScript(file.path(jspsych_dir, "plugins/jspsych_preloadprogressbar.js")),
  
  includeScript(
    # file.path(jspsych_dir, "plugins/jspsych_JLS/jspsych-html-button-response.js")
    file.path(jspsych_dir, "plugins/jspsych-html-button-response.js")
  ),
  
  includeScript(
    # file.path(jspsych_dir, "plugins/jspsych_JLS/jspsych-html-keyboard-response.js")
    file.path(jspsych_dir, "plugins/jspsych-html-keyboard-response.js")
  ),
  
  includeScript(
    # file.path(jspsych_dir, "plugins/jspsych_JLS/jspsych-fullscreen.js")
    file.path(jspsych_dir, "plugins/jspsych-fullscreen.js")
  ),
  
  includeScript(
    # file.path(jspsych_dir, "plugins/jspsych_JLS/jspsych-survey-text.js")
    file.path(jspsych_dir, "plugins/jspsych-survey-text.js")
  ),
  
  includeScript(
    # file.path(jspsych_dir, "plugins/jspsych_JLS/jspsych-survey-multi-choice.js")
    file.path(jspsych_dir, "plugins/jspsych-survey-multi-choice.js")
  ),
  
  includeScript(
    # file.path(jspsych_dir, "plugins/jspsych_JLS/jspsych-survey-html-form.js")
    file.path(jspsych_dir, "plugins/jspsych-survey-html-form.js")
  ),
  
  includeScript(
    # file.path(jspsych_dir, "plugins/jspsych_JLS/jspsych-survey-html-form.js")
    file.path(jspsych_dir, "plugins/jspsych-instructions.js")
  ),
  
  # Custom files
  includeCSS(file.path(jspsych_dir, "css/jspsych.css"))
  # includeCSS("css/style.css")
)

#########

##Greek
ui_greek <- tags$div(
  head,
  includeScript(file.path(base_dir, "greek-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

stroop_greek <- page(
  ui = ui_greek,
  label = "stroop_greek",
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

##Intro
ui_intro <- tags$div(
  head,
  includeScript(file.path(base_dir, "intro_text.js")),
  includeScript(file.path(base_dir, "intro-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

intro <- page(
  ui = ui_intro,
  label = "intro",
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)
  
##Instructions 1
ui_instr1 <- tags$div(
  head,
  includeScript(file.path(base_dir, "instr1_text.js")),
  includeScript(file.path(base_dir, "instr1-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

stroop_instr1 <- page(
  ui = ui_instr1,
  label = "stroop_instr1",
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

##Instructions 2
ui_instr2 <- tags$div(
  head,
  includeScript(file.path(base_dir, "instr2_text.js")),
  includeScript(file.path(base_dir, "instr2-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

stroop_instr2 <- page(
  ui = ui_instr2,
  label = "stroop_instr2",
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

##Practice
ui_prac <- tags$div(
  head,
  includeScript(file.path(base_dir, "prac_stimuli.js")),
  includeScript(file.path(base_dir, "prac-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

stroop_prac <- page(
  ui = ui_prac,
  label = "stroop_prac",
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

##Experiment
ui_exp <- tags$div(
  head,
  includeScript(file.path(base_dir, "test_stimuli.js")),
  includeScript(file.path(base_dir, "test-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

stroop_exp <- page(
  ui = ui_exp,
  label = "stroop_exp",
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

##SURVEY
#survey <- (

##Age, nationality and residence
ui_demographics <- tags$div(
  head,
  includeScript(file.path(base_dir, "demographics-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

demographics <- page(
  ui = ui_demographics,
  label = 'demographics',
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

##Gender
ui_gender <- tags$div(
  head,
  includeScript(file.path(base_dir, "gender-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

gender <- page(
  ui = ui_gender,
  label = 'gender',
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

##Education
ui_edu <- tags$div(
  head,
  includeScript(file.path(base_dir, "edu-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

education <- page(
  ui = ui_edu,
  label = 'education',
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

##Language1
ui_lang1 <- tags$div(
  head,
  includeScript(file.path(base_dir, "lang1-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

lang1 <- page(
  ui = ui_lang1,
  label = 'lang1',
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

##Language2
ui_lang <- tags$div(
  head,
  includeScript(file.path(base_dir, "lang_var.js")),
  includeScript(file.path(base_dir, "lang-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

stroop_lang <- page(
  ui = ui_lang,
  label = "stroop_lang",
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

##neuro
ui_neuro <- tags$div(
  head,
  includeScript(file.path(base_dir, "neuro-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

neuro <- page(
  ui = ui_neuro,
  label = "neuro",
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE
)

##Thanks
ui_thanks <- tags$div(
  head,
  includeScript(file.path(base_dir, "thanks_text.js")),
  includeScript(file.path(base_dir, "thanks-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

thanks <- page(
  ui = ui_thanks,
  label = "thanks",
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE,
)

##Final
ui_final <- tags$div(
  head,
  includeScript(file.path(base_dir, "final-timeline.js")),
  # includeScript(file.path(base_dir, "run-jspsych_full.js")),
  includeScript(file.path(base_dir, "run-jspsych.js")),
  tags$div(id = "js_psych", style = "min-height: 90vh")
)

final <- page(
  ui = ui_final,
  label = "final",
  get_answer = function(input, ...)
    input$jspsych_results,
  validate = function(answer, ...)
    nchar(answer) > 0L,
  save_answer = TRUE,
  final = TRUE
)

##elts
elts <- join(
  new_timeline(join(
   intro,
   demographics,
   gender,
   education,
   lang1,
   stroop_lang,
   neuro,
   elt_save_results_to_disk(complete = FALSE), # anything that is saved here counts as completed
   stroop_instr1,
   stroop_prac,
   elt_save_results_to_disk(complete = FALSE),
   stroop_instr2,
   stroop_exp,
   elt_save_results_to_disk(complete = TRUE),
   thanks,
   final), default_lang = "es")
)

##exp
exp <- make_test(
   elts = elts,
   opt = test_options(title="Stroop Task, Aarhus 2021",
                      admin_password="", # write a secret password here
                      enable_admin_panel=TRUE,
                      languages="es",
                      researcher_email="201902476@post.au.dk",
                      # problems_info="?Tiene problemas con el experimento? Env?e un email a 201902476@post.au.dk",
                      display = display_options(
                        full_screen = TRUE,
                        # content_border = "0px",
                        # show_header = FALSE,
                        # show_footer = FALSE,
                        # left_margin = 0L,
                        # right_margin = 0L,
                        css = file.path(jspsych_dir, "css/jspsych.css")
       )))

# shiny::runApp(".")
