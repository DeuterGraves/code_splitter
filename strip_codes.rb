def get_codes(strings_file)
  strings_data = File.read(strings_file).split
  strings_data

    # split into 2 arrays - 1 for .mp4s and the other for .srt
  strings_data.each do |string|
    if string.split(".").last = "mp4"
      puts "mp4"
    else string.split(".").last = "srt"
      puts "srt"
    end
  end
  # compare arrays - keep the mp4 items that don't match .srt items
  # get the codes from the orphan mp4s
end