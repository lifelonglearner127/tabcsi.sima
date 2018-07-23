# frozen_string_literal: true

module Api
  module V1
    class DistributorsController < BaseV1Controller
      def index
        success!(
          %w[
            A-B\ DISTRIBUTING\ OF\ SAN\ ANGELO
            ANDREWS\ DISTRIBUTING\ COMPANY\ OF\ NORTH\ TEXAS\ LLC
            ARTISANAL\ BEVERAGE\ DISTRIBUTORS\ LLC
            AUSTIN\ SPECIALTY\ FOODS
            BELLAIRE\ SAKE\ DISTRIBUTOR
            BEN\ E.\ KEITH\ BEERS
            BEN\ E.\ KEITH\ BEVERAGES
            BEN\ E.\ KEITH\ COMPANY
            BLUEBONNET\ DISTRIBUTING\ OPERATING\ LLC
            BUDWEISER\ DISTRIBUTING\ COMPANY\ OF\ BORGER
            CAPITOL\ WRIGHT\ DISTRIBUTING\ LLC
            COAM\ BEVERAGE\ INC.
            CORE-MARK\ MIDCONTINENT\ INC
            DASH\ DISTRIBUTING
            ER\ DISTRIBUTORS\ LLC
            FAUST\ DISTRIBUTING\ COMPANY
            FLOOD\ DISTIBUTION\ LLC
            FLOOD\ DISTRIBUTING
            FRIO\ DISTRIBUTING\ L.L.C.
            GIGLIO\ DISTRIBUTING\ COMPANY\ INC.
            GLAZER'S\ WHOLESALE\ DISTRIBUTORS
            GLAZER'S\ WHOLESALE\ DRUG\ COMPANY\ INC.
            GLI\ DISTRIBUTING
            GREAT\ PLAINS\ DISTRIBUTORS\ LP
            HOPS\ AND\ VINES\ DISTRIBUTING
            JACK\ HILLIARD\ DISTRIBUTING\ CO.\ INC.
            KEG\ 1\ O'NEAL\ LLC
            KEG\ 1\ O'NEAL\ NORTH\ TEXAS
            KEG\ 1\ O'NEAL\ TEMPLE
            KOSTAR\ IMPORTS
            KRISTEN\ DISTRIBUTING\ COMPANY
            L\ &\ F\ DISTRIBUTORS\ LLC
            LONE\ STAR\ BEER\ DISTRIBUTOR
            MEXCOR\ INC.
            MILLER\ OF\ AMARILLO
            PRICE\ DISTRIBUTING\ COMPANY
            PROMOTORA\ MEXSA
            REPUBLIC\ NATIONAL\ DISTRIBUTING\ COMPANY
            SILVER\ EAGLE\ DISTRIBUTORS\ L.P.
            STANDARD\ SALES\ COMPANY\ L.P.
            STAR\ DISTRIBUTING\ COMPANY
            STEVENSON\ BEER\ DISTRIBUTING\ COMPANY\ LTD.
            VICTORY\ WINE\ GROUP\ LLC
            WANDERING\ BOOTS\ BEVERAGE\ DISTRIBUTION,\ INC.
          ]
        )
      end
    end
  end
end
