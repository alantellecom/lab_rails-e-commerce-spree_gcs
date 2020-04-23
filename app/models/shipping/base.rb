require 'correios-frete'

class Shipping::Base < Spree::ShippingCalculator
  #attr_acessor :teste
  preference :zipcode, :string
  preference :default_weight, :float, :default => 0.3
  
  
  def compute_package(package)
    peso_total = 0
    package.order.line_items.each do |item|
      
      peso_total += item.quantity * (item.variant.weight || self.preferred_default_weight)
    end
    #binding.pry
    peso_total.to_f

    frete = Correios::Frete::Calculador.new :cep_origem => preferred_zipcode,
                                :cep_destino => package.order.ship_address.zipcode,                              
                                :peso => peso_total.to_s,
                                :comprimento => 30,
                                :largura => 15,
                                :altura => 2

    servico = frete.calcular self.tipo_servico
    servico.valor
  end

  
  # def peso_total_do_pedido(package)
  #   peso_total = 0
  #   pacote.order.line_items.each do |item|
      
  #     peso_total += item.quantity * (item.variant.weight || self.preferred_default_weight)
  #   end
  #   #binding.pry
  #   peso_total.to_f
  # end


end
