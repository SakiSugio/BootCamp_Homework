Sub stock_Analysis()
For Each ws In Worksheets
'Declare variables
Dim summaryRow As Integer
Dim totalVolume As Double
Dim tickerSymbol As String
Dim yearChange, percentChange As Double

'Initialize variables
 totalVolume = 0
 summaryRow = 2
 openingPrice = ws.Cells(2, 3).Value
'Create summary table: add colummn headers
    ws.Cells(1, 9).Value = "Ticker"
    ws.Cells(1, 10).Value = "Yearly Change"
    ws.Cells(1, 11).Value = "Percent Change"
    ws.Cells(1, 12).Value = "Total Stock Volume"
    
'Start loop to go through all rows
 For i = 2 To ws.Cells(Rows.Count, 1).End(xlUp).Row
    'Loop code
        If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
            tickerSymbol = ws.Cells(i, 1).Value
            totalVolume = totalVolume + ws.Cells(i, 7).Value
            yearChange = ws.Cells(i, 6).Value - openingPrice
            If openingPrice = 0 Then
                 percentChange = 0
            Else
                 percentChange = yearChange / openingPrice
            End If
            If yearChange < 0 Then
            'Set the color to Red
            ws.Cells(summaryRow, 10).Interior.ColorIndex = 3
        Else
            'Set the color to Green
            ws.Cells(summaryRow, 10).Interior.ColorIndex = 4
        End If
            'Printing the output on summary table
            ws.Range("I" & summaryRow).Value = tickerSymbol
            ws.Range("L" & summaryRow).Value = totalVolume
            ws.Range("J" & summaryRow).Value = yearChange
            ws.Range("K" & summaryRow).Value = percentChange
            ws.Range("K" & summaryRow).NumberFormat = "0.00%"
            totalVolume = 0
            summaryRow = summaryRow + 1
            openingPrice = ws.Cells(i + 1, 3).Value
        Else
            yearChange = ws.Cells(i, 6).Value - openingPrice
            totalVolume = totalVolume + Cells(i, 7).Value
       End If
      Next i
      
      
    'Declare variables
    lastRow = ws.Cells(Rows.Count, 10).End(xlUp).Row
    Dim MaxPercentage As Double
    Dim MinPercentage As Double
    Dim MaxTotal As Double
        
    'Table for max and min value
    ws.Cells(1, 16).Value = "Ticker"
    ws.Cells(1, 17).Value = "Value"
    ws.Cells(2, 15).Value = "Greatest % increase"
    ws.Cells(3, 15).Value = "Greatest % decrease"
    ws.Cells(4, 15).Value = "Greatest total volume"
    
    'Max value of Percent Change
    MaxPercentage = WorksheetFunction.Max(ws.Range("K2:K" & lastRow))
    'Min value of Percent Change
    MinPercentage = WorksheetFunction.Min(ws.Range("K2:K" & lastRow))
    'Max value of Total Stock Volume
    MaxTotal = WorksheetFunction.Max(ws.Range("L2:L" & lastRow))
    
    'Assiging value to the Greatest % Increase
    ws.Range("Q2").Value = MaxPercentage
    'Set the format to %
    ws.Range("Q2").NumberFormat = "0.00%"
    'assiging value to the greatest % decrease
    ws.Range("Q3").Value = MinPercentage
    'Set the format to %
    ws.Range("Q3").NumberFormat = "0.00%"
    'assiging value to the Greatest Total volume
    ws.Range("Q4").Value = MaxTotal
    
    'Finding the ticker for Max Percentage,Min Percentage & Max Total
    For j = 2 To ws.Cells(Rows.Count, 10).End(xlUp).Row
    If ws.Cells(j, 11) = MaxPercentage Then
        ws.Range("P2").Value = ws.Cells(j, 9).Value
    ElseIf ws.Cells(j, 11) = MinPercentage Then
        ws.Range("P3").Value = ws.Cells(j, 9).Value
    ElseIf ws.Cells(j, 12) = MaxTotal Then
        ws.Range("P4").Value = ws.Cells(j, 9).Value
    
    End If
    Next j
   Next ws
End Sub

