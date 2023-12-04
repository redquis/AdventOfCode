$i=0
$schematic = Get-Content "./Day3Input.txt" 
|%{
    ([regex]'(?<number>\d+)|(?<symbol>[@*/&#%+=$-])').Matches($_)
    |%{
        if($_.Groups[1].Success){
            [pscustomobject]@{type = "number";rows = ($i-1)..($i+1);columns = ($_.Index-1)..($_.Index + $_.Length);value = $_.Value -as [int]}
        } else {
            [pscustomobject]@{type = "symbol";row = $i;column = $_.Index;value = $_.Value}
        }
    }
    $i++
}

function Part1($Schematic) {

    $symbols = $Schematic | Where-Object type -eq symbol
    
    $Schematic 
    | Where-Object type -eq number 
    | Where-Object {
            foreach($symbol in $symbols){
                if($symbol.row -in $_.rows -and $symbol.column -in $_.columns){$true}
            }
        } 
    | Measure-Object -Property value -Sum 
    | Select-Object -ExpandProperty Sum
}

function Part2($Schematic) {

    $symbols = $Schematic | Where-Object value -eq '*'
    
    @(foreach($symbol in $symbols){
        $gears = @($Schematic
                    |Where-Object type -eq number
                    |Where-Object { $symbol.row -in $_.rows -and $symbol.column -in $_.columns }
                )
        if($gears.Count -eq 2){
            $gears[0].value * $gears[1].value
        }
    })
    | Measure-Object -Sum 
    | Select-Object -ExpandProperty Sum
}

Write-Output "Part 1: $(Part1 -Schematic $schematic)"
Write-Output "Part 2: $(Part2 -Schematic $schematic)"
