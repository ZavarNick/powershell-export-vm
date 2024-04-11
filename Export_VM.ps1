# Экспорт VM из Hyper-V
Export-VM -Name <NameVM> -Path "D:\export_vm"

# Получение текущей даты и переименование
$Now = Get-Date -format yyyy-MM-dd_HH-mm
Rename-Item -Path D:\export_vm\<NameVM> -NewName "<NameVM>_$Now"

# Параметры
$Path = "D:\export_vm"
$Days = 3 # Количество дней

# Вычисляем дату, которая будет использоваться для фильтрации
$CutoffDate = (Get-Date).AddDays(-$Days)

# Удаляем файлы старше указанного количества дней
Get-ChildItem -Path $Path -Recurse -File | Where-Object { $_.LastWriteTime -lt $CutoffDate } | Remove-Item –Force -Verbose

# Удаляем пустые каталоги
Get-ChildItem -Path $Path -Recurse -Directory | Where-Object { $_.GetFileSystemInfos().Count -eq 0 -and $_.CreationTime -lt $CutoffDate } | Remove-Item -Force -Recurse -Verbose