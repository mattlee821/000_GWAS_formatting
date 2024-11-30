import pandas as pd
from liftover import get_lifter

def convert_coordinates(data, from_build='hg19', to_build='hg38', chrom_col='CHR', pos_col='POS'):
    """
    Convert coordinates between two genome builds using the liftover inbuilt chain files.

    Parameters:
        data (pandas.DataFrame): DataFrame containing chromosome and position columns.
        from_build (str): The source genome build (default is 'hg19').
        to_build (str): The target genome build (default is 'hg38').
        chrom_col (str): The column name containing chromosome information (default is 'CHR').
        pos_col (str): The column name containing position information (default is 'POS').

    Returns:
        pandas.DataFrame: DataFrame with renamed POS column and an additional column for converted positions.
    """
    # Initialize the liftover converter with the specified genome builds
    converter = get_lifter(from_build, to_build, one_based=True)

    # Function to convert a single coordinate
    def convert_coordinate(chrom, pos):
        try:
            # Convert the position using liftover
            result = converter.convert_coordinate(str(chrom), pos)
            # Return the converted position if it exists, else return None
            return result[0][1] if result else None
        except Exception as e:
            print(f"Error converting {chrom}:{pos} -> {e}")
            return None

    # Add the converted positions as a new column
    converted_column = f"POS{to_build.upper()[2:]}"  # Target position column name, e.g., POS38
    data[converted_column] = data.apply(lambda row: convert_coordinate(row[chrom_col], row[pos_col]), axis=1)

    # Remove trailing .0 if the converted position is an integer
    data[converted_column] = data[converted_column].apply(lambda x: int(x) if pd.notnull(x) and x == int(x) else x)
    data[converted_column] = data[converted_column].astype('Int64', errors='ignore')  # 'Int64' supports NaNs

    # Rename the original POS column based on the source build
    renamed_column = f"POS{from_build.upper()[2:]}"  # Renamed column, e.g., POS19
    data.rename(columns={pos_col: renamed_column}, inplace=True)

    return data
