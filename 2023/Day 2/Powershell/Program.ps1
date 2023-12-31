$data=get-content ./Day2Input.txt
$games = $data | ForEach-Object {
    [String]$game, [String]$bags = $_ -split ": "
    [Int]$game_id = $game.TrimStart("Game ")

    [HashTable[]]$bags = $bags -split "; " | ForEach-Object {
        $bag = @{}
        $_ -split ", " | ForEach-Object {
            $count, $color = $_ -split " "
            $bag[$color] = [Int]$count
        }
        $bag
    }

    [PSCustomObject]@{
        game_id = $game_id;
        bags = $bags;
    }
}

function Part1($Games) {
    $Games `
    | Where-Object {
        $machingBags = 
            $_.bags `
            | Where-Object {
                $red, $green, $blue = ($_.red ?? 0), ($_.green ?? 0), ($_.blue ?? 0)
                $red -le 12 -and $green -le 13 -and $blue -le 14
            } `
            | Measure-Object

        $machingBags.Count -eq $_.bags.Count
    } `
    | Measure-Object -Sum -Property game_id `
    | Select-Object -ExpandProperty Sum
}


function Part2($Games) {
    $Games `
    | ForEach-Object {
        $_.bags `
        | Measure-Object -Maximum -Property red, green, blue `
        | ForEach-Object { $acc = 1 } { $acc *= $_.Maximum } { $acc }
    } `
    | Measure-Object -Sum `
    | Select-Object -ExpandProperty Sum
}

Write-Output "Part 1: $(Part1 -Games $games)"
Write-Output "Part 2: $(Part2 -Games $games)"
