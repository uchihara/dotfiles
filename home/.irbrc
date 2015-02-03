require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 200
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-history"
#IRB.conf[:PROMPT][:MY_PROMPT] = { # name of prompt mode
#  :PROMPT_I => "env: #{Rails.env}",          # normal prompt
#  :PROMPT_I => "test>",          # normal prompt
#}
#IRB.conf[:PROMPT_MODE] = :MY_PROMPT
#IRB.conf[:PROMPT_MODE] = :SIMPLE
if defined? Hirb
  Hirb.enable
end

