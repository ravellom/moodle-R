
# Load data from moodle .cvs reports 
# CARGAR DATOS DE LOS INFORMES DE MOODLE

# Librerías necesarias
library(lubridate)
library(tidyverse)

# Cargar solo un fichero
mdl <- read.csv("D:/Databases/moodle/27.04.21.csv",  
                encoding = "UTF-8")
                #encoding = "ISO-8859-1")
colnames(mdl) <- c("Hora", "Nombre_usuario", "Usuario_afectado",
                   "Contexto")

#### LEER varios csv de un directorio
mdl <-
        list.files(path = "D:/Databases/moodle/",
             pattern = "*.csv", 
             full.names = T) %>% 
        map_df(~read_csv(., col_types = cols(.default = "c"))) 

################ descomponer hora y fecha

mdl$datetime <- mdl$Hora
# Crear columna datetime para eliminar campo raro Ã¯..Hora para algunos servidores que generan este campo
mdl$datetime <- mdl$ï..Hora

# convertir fechas a standard de fecha porque las funciones no entienden el formato de Moodle
mdl$dts <- as.POSIXct(strptime(mdl$datetime, "%d/%m/%Y %H:%M"))
# descomponer fecha y hora para trabajar con estos campos 
mdl$date <- as.Date(mdl$datetime, "%d/%m/%y")
mdl$year <- year(mdl$date)
mdl$month <- month(mdl$date)
mdl$mday <- mday(mdl$date)
mdl$hour <- hour(mdl$dts)
mdl$weekday <- wday(mdl$dts) # 1 al 7 - dom a sab
# TRUE si es sab o dom  FALSE si e lun a vie
mdl$weekday_str <- mdl$weekday == 1 | mdl$weekday == 7


