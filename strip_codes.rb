# pass in the extensions - more versatile
def get_orphan_codes(input_file, output_filename)
  strings_data = File.read(input_file).split

  mp4s = build_array(strings_data, "mp4")
  srts = build_array(strings_data, "srt")

  # build arrays of the codes to compare below
  mp4_codes = get_codes(mp4s)
  srt_codes = get_codes(srts)

  orphan_codes = mp4_codes - srt_codes

  codes = orphan_codes.uniq

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


def get_codes(filenames)
  codes = []

  filenames.each do |filename| 
    code = filename.split("_")[-2]
    codes << code
  end
  codes
end

def save_to_file(codes, output_filename)
  File.open("#{output_filename}.txt", 'w') {|file| file.puts codes }
end


# take output list, get an input file list compare the codes on each and remove codes that have been downloaded
def update_code_list(codes_file, new_files_list, output_filename)
  requested_codes = File.read(codes_file).split
  new_files = File.read(new_files_list).split

  new_codes = build_codes_array(new_files)

  updated_codes = requested_codes - new_codes

  save_to_file(updated_codes, output_filename)
end

def build_codes_array(strings_data)
  new_codes = []

  strings_data.each do |file|
    new_code = file.split("_")[-2]
    new_codes << new_code
  end

  new_codes
end


