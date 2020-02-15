def get_orphan_codes(strings_file)
  strings_data = File.read(strings_file).split

  mp4s = build_array(strings_data, "mp4")
  srts = build_array(strings_data, "srt")

  orphan_mp4s = mp4s - srts

  get_codes(orphan_mp4s).uniq

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


def get_codes(orphan_mp4s)
  codes = []

  orphan_mp4s.each do |mp4| 
    code = mp4.split("_")[-2]
    codes << code
  end
  codes
end
