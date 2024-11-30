def save_file_with_retries(filelist_df, file_path, max_attempts=3):
    attempt = 0
    success = False

    while attempt < max_attempts and not success:
        try:
            filelist_df.to_csv(file_path, sep='\t', index=False)
            print(f"## Processed file saved to {file_path} on attempt {attempt + 1}", flush=True)
            success = True
        except Exception as e:
            attempt += 1
            print(f"Error encountered on attempt {attempt}: {e}", flush=True)

            if attempt < max_attempts:
                print("Retrying...", flush=True)
            else:
                print(f"Failed to save the file after {max_attempts} attempts.", flush=True)
