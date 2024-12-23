class TextToSpeech < ApplicationJob
  queue_as :default

  def perform(content)
    command = "python /home/catalin/play/tts/tts.py --text " + "'#{content.body}' " + "--id #{content.id}"
    puts "COMMAND #{command}"

    content.create_kernel_command!(
      body: command
    )

    system(
      command
    )
  end
end
