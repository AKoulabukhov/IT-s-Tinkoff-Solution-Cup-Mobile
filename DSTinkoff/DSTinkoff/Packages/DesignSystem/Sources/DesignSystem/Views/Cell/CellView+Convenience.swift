import Foundation

public typealias RightImageTextCellView = CellView<CellEmptyComponentView, CellTextComponentView, CellImageComponentView>
public typealias LeftImageTextCellView = CellView<CellImageComponentView, CellTextComponentView, CellEmptyComponentView>
public typealias ImageTextCloseCellView = CellView<CellImageComponentView, CellTextComponentView, CellCloseComponentView>
public typealias TextButtonCellView = CellView<CellEmptyComponentView, CellTextComponentView, CellButtonComponent>
