
Spree::HomeController.class_eval do
    helper 'spree/products'
    respond_to :html

    def index
    @searcher = build_searcher(params.merge(include_images: true))
    
    #if spree_current_user
        @products = @searcher.retrieve_products #.where(meta_description: spree_current_user.email)
    #else
        #@products = @searcher.retrieve_products #.where(meta_description: '@#$valornulo@#$')
    #end 
    #binding.pry        
    @products = @products.includes(:possible_promotions) if @products.respond_to?(:includes)
    @taxonomies = Spree::Taxonomy.includes(root: :children)
    end
end
