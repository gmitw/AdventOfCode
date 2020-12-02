$numbers = Get-Content .\input.txt

foreach($number in $numbers) {
    foreach($SecondNumber in $numbers) {
       foreach($ThirdNumber in $numbers) {        
        $sum = [int]$number + [int]$SecondNumber + [int]$ThirdNumber
        if($sum -eq 2020) {
            $solution = [int]$number * [int]$SecondNumber * [int]$ThirdNumber
            write-host $solution
            exit
            }
        }
    }
}