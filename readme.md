# This is a little thought experiment

## Background:
I have a list of video files, and most of them have companion subtitle files, but some are missing and I wanted a list of the missing ones, then I wanted to extract just a portion of the filename of the files shown not to have a match... then I thought 'hrm, would be useful to output to a text file...' and now I'm thinking, I'm at a decent stopping point. 

`get_orphan_codes` compares the list of MP4 files to the list of subtitle files and creates a list of MP4s that are missing subtitles.

`update_code_list` compares a list of codes from newly aquired subtitle files to the orphaned list previously created to remove files that are no longer missing

## Notes for me to remember how to use this down the road. 
1. Have a file with a list of the files in it, they should each be on their own line, no additional punctuation needed.
2. Can run it from a folder different from the location of the input file and save the output in another file - just include the file locations in the filenames passed in i.e. "../input.txt"
3. It's currently hard coded to compare .mp4 files to .srt files with the assumption that the subtitle files are in the minority, and that there are potentially mp4 files that don't have an associated subtitle file. 
4. Position refers to where in the array created when the string is split on underscores the string you want is located. 
5. If you pass in an exisiting filename as your output file - the output file will be overwritten with the new data. 

To run methods:
`ruby -r "./strip_codes" -e "StripCodes.get_orphan_codes '../230820_azul.txt', '../230820_azul_orphans'"`

## Pro Tips
- Clearing out the folder structure in a `file_list.txt` file in 1 sweep: `^.*\\` that found multiple layers of folders i.e. `\folder 1\folder 2\` and then just replace with blank and done. The script seems to throw out list items from the files that aren't relevant file names (I'm writing this ages after writing the original script - hence "seems").

## Next up/Ideas for changes and improvements:
- improve formatting on the file that's created
- Some files end up duplicated because the filenames are ever so slightly different
  - second script to re-name the video files to match the subtitle files.
    - should have y/n before changing the filename
- need to do this properly with classes and make this a proper app I guess. 
- Could also make the position input an array - allowing a user to grab a series of items from the array that results from splitting the string on underscores.
- Currently the filenames split on an underscore, it might be interesting/wise/useful to make the split character(s) a variable.
