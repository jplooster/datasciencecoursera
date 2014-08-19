library(shiny) 

blackscholes <- function(S, X, rf, T, sigma) {
        values <- NULL
        
        d1 <- (log(S/X)+(rf+sigma^2/2)*T)/(sigma*sqrt(T))
        d2 <- d1 - sigma * sqrt(T)
        
        values[1] <- S*pnorm(d1) - X*exp(-rf*T)*pnorm(d2)
        values[2] <- X*exp(-rf*T) * pnorm(-d2) - S*pnorm(-d1)
        names(values) <- c("call", "put")
        round(values, 4)
}

shinyServer(
        function(input, output) {
                inputValues <- reactive({
                        
                        # Compose data frame
                        data.frame(
                                Name = c("Spot Price", 
                                         "Strike Price",
                                         "Volatility",
                                         "Risk Free Rate",
                                         "Time to maturity"),
                                Value = as.character(c(input$S1+input$S2, 
                                                       input$X1+input$X2,
                                                       input$vol,
                                                       input$rate,
                                                       input$date - Sys.Date())), 
                                stringsAsFactors=FALSE)
                }) 
                output$values <- renderTable({
                        inputValues()
                        })
        
                
                output$prices <- renderPrint({
                        blackscholes(S = input$S1 + input$S2, 
                                        X = input$X1 + input$X2, 
                                        rf = input$rate/100, 
                                        T = as.numeric((input$date - Sys.Date())/365),                                                 sigma = input$vol/100)
                        })
        } )