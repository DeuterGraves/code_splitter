def get_codes(strings_file)
  strings_data = File.read(strings_file).split
  # strings_data
    # split into 2 arrays - 1 for .mp4s and the other for .srt
    mp4s = build_array(strings_data, "mp4")
    mp4s
  # compare arrays - keep the mp4 items that don't match .srt items
  # get the codes from the orphan mp4s
end

def build_array(strings_data, extension)
  array = []

  strings_data.each do |string|
    if string.split(".").last == extension
      array << string
    end
  end 
  array 
end
