import sys
import argparse
import itertools
import openpyxl

# Define command line argument parser
parser = argparse.ArgumentParser(description='Convert xlsx file to tab-delimited text file.')
parser.add_argument('input_file', metavar='input_file', type=str, help='Path to input xlsx file.')
parser.add_argument('output_file', metavar='output_file', default="combinations.txt", type=str, help='Path to output txt file.')
parser.add_argument('start_index', metavar='start_index', nargs='?', type=int, help='Which row to start with.')
parser.add_argument('end_index', metavar='end_index', nargs='?', type=int, help='Which row to end with.')
args = parser.parse_args()

# Load input xlsx file
workbook = openpyxl.load_workbook(args.input_file)
worksheet = workbook.active

# Get all values in the first column of the spreadsheet
values = [cell.value for cell in worksheet['A']]

if args.start_index:
    starti = args.start_index
else:
    starti = 1
if args.end_index:
    endi = args.end_index
else:
    endi = len(values)
if starti >= endi:
    print("Ending index must be greater that starting index. Exiting.")
    sys.exit()
if (starti > len(values)) or (endi > len(values)):
    print("Start and end indexes must not be greater than the number of rows in the input file. Exiting.")
    sys.exit()

print("Starting with row " + str(starti) + ".")
print("Ending with row " + str(endi) + ".")

valsel = values[starti-1:endi]

# Generate all combinations of strings
combinations = [''.join(x) for x in itertools.product(valsel, repeat=2)]

index_combinations = ['\t'.join([str(i) for i in x]) for x in itertools.product(range(endi-starti+1, 1, -1), range(1, endi-starti+2), repeat=1)]

output = ["{}\t{}".format(a_, b_) for a_, b_ in zip(combinations, index_combinations)]

# Write combinations to a text file
with open(args.output_file, 'w') as outfile:
    outfile.write('\n'.join(output))

print("Index complete!")
