class Person < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :person_families
  has_many :families, :through => :person_families
  belongs_to :mother, :class_name => Person, :foreign_key => :mother_id
  belongs_to :father, :class_name => Person, :foreign_key => :father_id
  belongs_to :spouse, :class_name => Person, :foreign_key => :spouse_id
  

  def siblings
    Person.where("mother_id = ? OR father_id = ?", mother_id, father_id).where.not("id = ?", self.id)
  end

  def brothers
    siblings.select {|sibling| sibling.gender == "M"}
  end

  def sisters
    siblings.select {|sibling| sibling.gender == "F"}
  end

  def children
    Person.where("mother_id = ? OR father_id = ?", self.id, self.id)
  end

  def grandmothers
    {maternal: mother.mother, paternal: father.mother}
  end

  def grandfathers
    {maternal: mother.father, paternal: father.father}
  end

  def default_family
    self.families[0]
  end
end
