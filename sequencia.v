module Sequencia (
    input wire clk,
    input wire rst_n,

    input wire setar_palavra,
    input wire [7:0] palavra,

    input wire start,
    input wire bit_in,

    output reg encontrado
);

reg [7:0] sequencia_alvo;    
reg [7:0] buffer_entrada; 
reg busca_ativa;

always @(posedge clk) 
begin

    if(!rst_n) 
    begin
        sequencia_alvo <= 8'b0;
        buffer_entrada <= 8'b0;
        encontrado <= 1'b0;
        busca_ativa <= 1'b0;
    end 
    else 
    begin

        if(setar_palavra) 
        begin
            sequencia_alvo <= palavra;
        end

        if(start) // Iniciar a busca
        begin
            busca_ativa <= 1'b1;
        end 
        else if(encontrado)
        begin

            busca_ativa <= 1'b0;
        end

        if(busca_ativa && !encontrado) // Processar bit de entrada e deslocar o buffer
        begin
           
            buffer_entrada <= {buffer_entrada[6:0], bit_in};
        end

        if(busca_ativa && !encontrado) 
        begin
            if(buffer_entrada == sequencia_alvo) // encontrou!
            begin
                encontrado <= 1'b1;
            end
        end
    end
end

endmodule
