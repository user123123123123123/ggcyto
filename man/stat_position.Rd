% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/stat_position.R
\name{stat_position}
\alias{stat_position}
\alias{stat_position.filter}
\alias{stat_position.filterList}
\alias{stat_position.list}
\title{Compute the positions of the population statistics based on the geometic gate centroid for a ggcyto plot.}
\usage{
stat_position(gate, ...)

\method{stat_position}{filter}(
  gate,
  negated = FALSE,
  adjust = 0.5,
  location = "gate",
  data_range = NULL,
  limits = NULL,
  ...
)
}
\arguments{
\item{gate}{a flowCore filter}

\item{...}{other arguments}

\item{negated}{logical indicating whether position needs to be moved to negative side of gate}

\item{adjust}{see details}

\item{location}{see details}

\item{data_range}{a two-row data.frame representing the actual data range. Each column is a a range for a specific channel. First row is min, Second row is max.}

\item{limits}{used to fix the gate range}
}
\value{
a data.table of gate centroid coordinates
}
\description{
It is usually not called directly by user but mainly used by compute_stats function (which is called by ggcyto add method when geom_states layer is added).
}
\details{
\subsection{Specifying location for statistical annotation}{

The \code{adjust} and \code{location} arguments allow for a few different ways to adjust the location of the statistical
annotation for a gate on a \code{ggcyto} plot. The valid values for \code{location} are "gate" (default), "data", "plot", and "fixed".
\subsection{Relative location}{

If \code{location} is not "fixed", the starting position of the annotation will be determined with respect to a rectangular window whose
bounds are determined in the following way:
\itemize{
\item For \code{location = "gate"}, the window will be set by the range of the data in the gate
\item For \code{location = "data"}, the window will be set by the range of values in all of the data on the plot (provided by \code{data_range})
\item For \code{location = "plot"}, the window will be set by the axis limits of the plot (adjusted by \code{\link{ggcyto_par_set}})
}

This starting position can then be adjusted by passing values in a vector to the \code{adjust} parameter, where they will be
interpreted as relative proportions of the window dimension, where 0.0 represents the lower bound of the dimension and 1.0 represents
the upper bound. So, for a 2-D plot, \code{adjust=c(0,0)} places the annotation at the lower left corner of this window and \code{adjust=c(1,1)} places
it at the upper right corner.

As another example, for a 2-D gate, if \code{location = "gate"} and \code{adjust=c(0.25, 0.75)}, the statistical annotation will be
placed 1/4 of the way across the x-range of the gate and 3/4 of the way across the y-range of the gate.

The \code{adjust} argument will also accept values less than 0.0 or greater than 1.0. This can be an easy way
to simply move the annotation outside of a gate so it does not obstruct the view of the data within. For example, \code{location == "gate"}
and \code{adjust=c(-0.2, 1.2)} will move the annotation outside of the upper left corner of the gate range.
}

\subsection{Fixed location}{

If \code{location = "fixed"}, the numeric vector passed to \code{adjust} will be interpreted as values on the data scales of the plot to provide
an explicit location for the annotation.

For example, if the annotation should be at the location 3000, 5000 on the plot, that could be done with \code{location="fixed"} and
\code{adjust = c(3000,5000)}.
}

\subsection{Default}{

The default behavior if no values are provided to \code{location} or \code{adjust} will be to place the annotation at
the center of the range of the data in the gate.
}

}
}
\examples{
data(GvHD)
fs <- GvHD[1:4]
rect.g <- rectangleGate(list("FSC-H" =  c(300,500), "SSC-H" = c(50,200)))
rect.gates <- sapply(sampleNames(fs), function(sn)rect.g)
stat_position(rect.gates)
}
