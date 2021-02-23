@react.component
let make = (~left: React.element, ~right: React.element) => {
  <div className="flex flex-col md:flex-row w-full h-full items-center justify-center">
    left <div className="w-0 h-4 md:h-0 md:w-16" /> right
  </div>
}
