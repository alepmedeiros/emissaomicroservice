@echo off
:: Configura as variáveis de ambiente do Delphi
call "C:\Program Files (x86)\Embarcadero\Studio\23.0\bin\rsvars.bat"

:: Verifica se os argumentos foram passados
if "%~1"=="" (
    echo Erro: Caminho do diretório do projeto não especificado.
    echo Uso: build.bat [CaminhoDoDiretorio] [NomeDoProjeto.dproj]
    exit /b 1
)

if "%~2"=="" (
    echo Erro: Nome do projeto não especificado.
    echo Uso: build.bat [CaminhoDoDiretorio] [NomeDoProjeto.dproj]
    exit /b 1
)

:: Navega para o diretório do projeto
cd /d "%~1"
if %errorlevel% neq 0 (
    echo Erro: Não foi possível acessar o diretório do projeto: %~1.
    exit /b %errorlevel%
)

:: Compilação do projeto
echo Compilando o projeto %~2 para Linux...
msbuild "%~2" /p:Config=Release /p:Platform=Linux64
if %errorlevel% neq 0 (
    echo Erro ao compilar o projeto: %~2.
    exit /b %errorlevel%
)

echo Compilação concluída com sucesso!
exit /b 0
