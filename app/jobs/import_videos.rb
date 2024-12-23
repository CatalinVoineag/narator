class ImportVideos < ApplicationJob
  queue_as :default

  def perform
    folder_path = "/home/catalin/play/tts/audios"

    files, stderr, status = Open3.capture3("ls #{folder_path}")
    files = files.split("\ ")

    files.each do |file|
      id = file.split("_").last.split(".").first
      audio_file_path = "#{folder_path}/#{file}"
      content = Content.find_by(id:)

      if content
        content.audio.attach(
          io: File.open(audio_file_path),
          filename: file,
          content_type: "audio/wav"
        )

        File.delete(audio_file_path)
      end
    end
  end
end
