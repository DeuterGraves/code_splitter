def get_codes(strings_file)
  strings_data = File.read(strings_file).split
  mp4s = build_array(strings_data, "mp4")
  srts = build_array(strings_data, "srt")
  # compare arrays - keep the mp4 items that don't match .srt items
  orphan_mp4s = mp4s - srts
  # get the codes from the orphan mp4s
end

def build_array(strings_data, extension)
  array = []

  strings_data.each do |string|
    if string.split(".").last == extension
      array << string.chomp(".#{extension}")
    end
  end 
  array 
end
