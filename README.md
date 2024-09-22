# Multi-Directory WebM to MP4 Converter

This script is designed to help Ubuntu users who frequently work with WebM files and need an automated solution to convert them to MP4 format. It was created to address the common issue of dealing with WebM files, which are often the default output for screen recordings in some Linux environments.

## Features

- Automatically converts WebM files to MP4 format
- Monitors multiple directories simultaneously
- Processes existing WebM files and watches for new ones
- Uses FFmpeg for efficient and high-quality conversion
- Removes the original WebM file after successful conversion

## Prerequisites

Before you can use this script, make sure you have the following installed on your Ubuntu system:

- FFmpeg
- inotify-tools

You can install these prerequisites using the following command:

```bash
sudo apt update && sudo apt install ffmpeg inotify-tools
```

## Installation

1. Clone this repository or download the script file:

```bash
git clone https://github.com/thiagoassisk8/webm-to-mp4-converter.git
```

2. Make the script executable:

```bash
chmod +x multi-dir-webm-to-mp4-converter.sh
```

## Usage

1. Open the script in a text editor.

2. Modify the `WATCH_DIRS` array to include the directories you want to monitor. By default, it's set to:

```bash
WATCH_DIRS=(
    "$HOME/Vídeos/Screencasts"
    "$HOME/Vídeos/Webcam"
)
```

3. Save the changes and close the editor.

4. Run the script:

```bash
./multi-dir-webm-to-mp4-converter.sh
```

The script will start monitoring the specified directories. It will convert any existing WebM files and then watch for new WebM files to convert automatically.

## How It Works

1. The script first checks for and converts any existing WebM files in the specified directories.
2. It then enters a monitoring mode, watching for any new WebM files created in these directories.
3. When a new WebM file is detected, the script automatically converts it to MP4 format.
4. After successful conversion, the original WebM file is removed to save space.

## Customization

You can adjust the FFmpeg conversion settings in the `convert_to_mp4` function if you need to balance between conversion speed and output quality.

## Troubleshooting

If you encounter any issues:

1. Ensure you have the necessary permissions to read from and write to the monitored directories.
2. Check that FFmpeg and inotify-tools are correctly installed.
3. Verify that the paths in the `WATCH_DIRS` array are correct for your system.

## Contributing

Feel free to fork this repository and submit pull requests to contribute to this project. For major changes, please open an issue first to discuss what you would like to change.

