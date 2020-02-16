# pass in the extensions - more versatile
def get_orphan_codes(input_file, output_filename)
  strings_data = File.read(input_file).split

  mp4s = build_array(strings_data, "mp4")
  srts = build_array(strings_data, "srt")

  orphan_mp4s = mp4s - srts

  codes = get_codes(orphan_mp4s).uniq

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

def get_codes(orphan_mp4s)
  codes = []

  orphan_mp4s.each do |mp4| 
    code = mp4.split("_")[-2]
    codes << code
  end
  codes
end

def save_to_file(codes, output_filename)
  File.open("#{output_filename}.txt", 'w') {|file| file.puts codes }
end


# take output list, get an input file list compare the codes on each and remove codes that have been downloaded
def update_code_list(codes_file, new_files_list)
  requested_codes = File.read(codes_file).split
  new_files = File.read(new_files_list).split

  #trim new_files down to just the codes - this should be split out.
  new_codes = []
  new_files.each do |file|
    new_code = file.split("_")[-2]
    new_codes << new_code
  end

  # new_codes

  updated_codes = requested_codes - new_codes

end

