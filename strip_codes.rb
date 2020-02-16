# pass in the extensions - more versatile
def get_orphan_codes(input_file, positions, output_filename)
  strings_data = File.read(input_file).split

  mp4s = build_array(strings_data, "mp4")
  srts = build_array(strings_data, "srt")

  orphan_mp4s = mp4s - srts

  codes = get_codes(orphan_mp4s, positions).uniq

  save_to_file(codes, output_filename)
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

def get_codes(orphan_mp4s, positions)
  codes = []

  orphan_mp4s.each do |mp4| 
    # how to get the array passed in to be used as an array?
    code = mp4.split("_")[positions]
    codes << code
  end
  codes
end

def save_to_file(codes, output_filename)
  File.open("#{output_filename}.txt", 'w') {|file| file.puts codes }
end