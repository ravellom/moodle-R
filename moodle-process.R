## Librerías necesarias
library(tidyverse)
library(lubridate)
library(viridis)

### Usuarios ------------------------

# Agrupar usuarios con clases virtuales
mdl_usr <- mdl %>% group_by(User = mdl$`Nombre completo del usuario`) %>% 
  summarise(n = n()) %>%
  #subset(n > 400, na.rm = TRUE)  %>%  # mÃ¡s de x accesos
  #subset(n < 5000, na.rm = TRUE)  #%>% # menos de x acessos
  arrange(desc(n)) %>% # ordenar
  filter(User != "-")  # Eliminar usuario "-"

mdl_usr <- mdl_usr[-1,] # Eliminar Admin 
dim(mdl_usr)

mdl_usr_28 <- mdl28 %>% group_by(User = Nombre.completo.del.usuario) %>% 
  summarise(n = n()) %>%
  #subset(n > 400, na.rm = TRUE)  %>%  # mÃ¡s de x accesos
  #subset(n < 5000, na.rm = TRUE)  #%>% # menos de x acessos
  arrange(desc(n)) %>% # ordenar
  filter(User != "-")  # Eliminar usuario "-"

# Graficar usuarios por cantidad de accesos
ggplot(head(mdl_usr, 15), aes(x = reorder(User,n), n, fill=User)) +
  geom_bar(stat="identity", show.legend = FALSE) + 
  coord_flip() +
 # theme_my_style() +
  labs(title="Usuarios con mayor actividad", 
       #subtitle = "Fecha",
       #caption="fuente: clasesvirtuales.ucf.edu.cu", 
       y="Cantidad de accesos",
       x="Usuarios",
       color=NULL,
       family = "Helvetica") 

# Agrupar usuarios X dÃ­a
mdl_usr2 <- mdl %>% group_by(fecha = mdl$date, User = mdl$`Nombre completo del usuario`) %>%
  summarise() 
mdl_usr3  <-  mdl_usr2 %>% group_by(fecha) %>%
  summarise(no = n())  
ggplot(mdl_usr3, aes(x = as_date(fecha), y = no)) +
  geom_line(color = "#1380A1", size = 1) +
  geom_hline(yintercept = 0, size = 1, colour="#333333") +
#  theme_my_style() +
  labs(title="Usuarios conectados por día", 
#       subtitle = "Feb 10 - Mar 10 2021",
#       caption="fuente: clasesvirtuales.ucf.edu.cu", 
#       y="Usuarios",
       x="Fecha") 
# geom_point(size = 2, colour="#333333", alpha = 1/3) +
# geom_hline(yintercept = 50, size = 1, colour = "red", linetype = "dashed")

mean(mdl_usr2[1:8,]$no)
