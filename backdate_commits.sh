#!/bin/bash

# Set start and end dates
start_date="2016-01-01"
end_date="2024-03-20"  # Adjust this to today's date
repo_path="$HOME/fancy_job"  # Change this to your repo's actual path

# Navigate to repo
cd "$repo_path" || exit

# Loop through each day from start_date to end_date
while [ "$(date -d "$start_date" +%Y-%m-%d)" != "$(date -d "$end_date" +%Y-%m-%d)" ]; do
    for i in {1..3}; do  # 3 commits per day
        export GIT_COMMITTER_DATE="$start_date 12:$((RANDOM % 60)):$(($RANDOM % 60))"
        export GIT_AUTHOR_DATE="$start_date 12:$((RANDOM % 60)):$(($RANDOM % 60))"
        
        echo "$start_date - Commit #$i" >> number.txt
        git add number.txt
        git commit -m "Backdated commit for $start_date - #$i"
    done

    # Move to the next day
    start_date=$(date -I -d "$start_date + 1 day")
done

# Push all commits
git push origin main
